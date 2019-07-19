dataconsolidate <- function(d)
{
  d=choose.dir() #function for choosing the folder
  a=list.files(path = d ,recursive=TRUE,full.name = TRUE) #function to fetch all the paths recursively
  b=unique(dirname(a)) #fetching the paths of subfolder
  dataset<-data.frame() #initialising dataset in which all files concatenate
  for (i in 1:length(b))

  {
    file_list=list.files(path = b[i],pattern = "csv$") #using pattern to search .csv in folder

    setwd(b[i]) #Changing Working Directory as path to search files

    for (file in file_list){
      # dataset (in line 6) which is initialized in the above code is used to append the results into it.
      #temp_dataset is created in which each file is saved and added to dataset.
      temp_dataset <-read.table(file, header=TRUE, sep="|")
      dataset<-rbind(dataset, temp_dataset) #binding each file to dataset
      rm(temp_dataset) #initialising (clearing)after rowbind operation

    }
  }
  setwd(d) # setting the same directory from where the files are chosen
  write.table(x=dataset,file='consolidated_dataset.csv')
  return(dataset)
}
