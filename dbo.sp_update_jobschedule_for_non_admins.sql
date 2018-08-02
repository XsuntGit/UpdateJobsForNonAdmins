USE [msdb]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE or ALTER PROCEDURE [dbo].[sp_update_jobschedule_for_non_admins] -- This SP is deprecated by sp_update_schedule.
(
	@job_id                 UNIQUEIDENTIFIER    = NULL,
	@job_name               sysname             = NULL,
	@name                   sysname,
	@new_name               sysname             = NULL,
	@enabled                TINYINT             = NULL,
	@freq_type              INT                 = NULL,
	@freq_interval          INT                 = NULL,
	@freq_subday_type       INT                 = NULL,
	@freq_subday_interval   INT                 = NULL,
	@freq_relative_interval INT                 = NULL,
	@freq_recurrence_factor INT                 = NULL,
	@active_start_date      INT                 = NULL,
	@active_end_date        INT                 = NULL,
	@active_start_time      INT                 = NULL,
	@active_end_time        INT                 = NULL,
	@automatic_post         BIT                 = 1 -- If 1 will post notifications to all tsx servers to that run this job
)
WITH EXECUTE AS OWNER
AS

BEGIN
	EXEC sp_update_jobschedule
		@job_id ,
		@job_name ,
		@name ,
		@new_name ,
		@enabled ,
		@freq_type ,
		@freq_interval ,
		@freq_subday_type ,
		@freq_subday_interval ,
		@freq_relative_interval ,
		@freq_recurrence_factor,
		@active_start_date ,
		@active_end_date ,
		@active_start_time ,
		@active_end_time ,
		@automatic_post

END
GO
