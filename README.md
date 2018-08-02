
# Update Jobs For Non Admins

## Objective and Description

As known, only users with granted **sysadmin** server role can create, modify or delete existing local jobs. Whichever user, who is not granted that server role, is going to try do any kind of modification to a job will get the following message:

>*Only members of sysadmin role are allowed to update or delete jobs owned by a different login.*

I created 3 stored procedures to work this around the way if a user granted **SQLAgentOperatorRole** fixed MSSQL Server Agent role will have a way to modify existing local jobs:
- ```[dbo].[sp_update_job_for_non_admins]``` - this procedure will allow modifying any existing job as changing its name, add description, disable/enable it, re-arrange steps sequence, etc.;
- ```[dbo].[sp_update_jobstep_for_non_admins]``` - this procedure will allow modifying any step's content as changing the step name, modify command statement, specify different database under which the command is going to be issued under, etc.;
- ```[dbo].[sp_update_jobschedule_for_non_admins]``` - this procedure will allow modifying job's schedule as changing the name of the schedule, disable/enable it, modify schedule's frequency, etc.;

## Examples

1. Rename current job ```'Cimzia -- Starting Call Numbers'``` into ```'Cimzia Starting Call Numbers'```:
```sql
USE msdb
GO
EXEC dbo.sp_update_job_for_non_admins
      @job_name = 'Cimzia -- Starting Call Numbers',
      @new_name = 'Cimzia Starting Call Numbers';
GO
```
2. Disable ```'Axtria -- Copay Card Reports'``` current job:
```sql
USE msdb
GO
EXEC dbo.sp_update_job_for_non_admins
      @job_name = 'Axtria -- Copay Card Reports',
      @enabled = 0;
GO
```
3. Update command for step number 1 in ```'Enbrel -- Daily Run'``` job:
```sql
USE msdb
GO
EXEC dbo.sp_update_jobstep_for_non_admins
    @job_name = 'Enbrel -- Daily Run',
    @step_id = 1,
    @command = 'exec [dbo].[sp_EnbrelReporting_CopaybyMerchantProcess]';
GO 
```
4. Update job's schedule's name from ```'Enbrel -- Daily Run'``` to ```'Enbrel Daily Run schedule'```, enable the schedule and update the job's schedule to have it running ***every day every 1 hour(s) between 12:00:00 AM and 11:59:59 PM.*** :
```sql
USE msdb
GO
EXEC dbo.sp_update_jobschedule_for_non_admins
    @job_name = N'Enbrel -- Daily Run',
    @name = N'Enbrel -- Daily Run',
    @new_name = N'Enbrel Daily Run schedule',
    @enabled=1, 
    @freq_type=4, 
    @freq_interval=1, 
    @freq_subday_type=8, 
    @freq_subday_interval=1, 
    @freq_relative_interval=0, 
    @freq_recurrence_factor=1, 
    @active_start_date=20180802, 
    @active_end_date=99991231, 
    @active_start_time=0, 
    @active_end_time=235959
GO
```
