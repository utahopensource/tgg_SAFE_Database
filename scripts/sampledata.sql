  Select events.Insert_refugeevent (1,2,3,'this is a test note','01-07-17',true) 
  Select caseworker.Insert_CaseWorkerProfile ('pat','wright','222-333-4567','sqlasylum@gmail.com');
  Select caseworker.Delete_caseworkerprofile(5)                         
  Select events.Delete_refugeevent(5)  
  Select refugee.Delete_refugeeprofile(5)
  Select refugee.Insert_refugeeProfile ('pat','wright','222-333-4567','sqlasylum@gmail.com');

  Select refugee.Update_refugeeprofile(2,'pot','wrong','222-333-4567','sqlasylum@gmail.com')
Select caseworker.Update_caseworkerprofile(2,'pot','wrong','222-333-4567','sqlasylum@gmail.com',true)

  Select events.Update_refugeevent(2,1,2,3,'testing my new row','2017-01-14',false)

  