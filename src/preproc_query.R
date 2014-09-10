preproc_query<-function() {
	# Pre-process query output to create line breaks.
	flist<-Sys.glob('*txt')
	for (outf in flist) {
		system(paste('echo "" >> ',outf,sep=''))
		w<-gsub('.txt','',outf)
		s<-readLines(con=outf)
		s<-gsub('\t',' ',s)
		s<-gsub(w,paste('!!@@',w,sep=''),s)
		slist<-unlist(strsplit(x=s,split='!!@@'))
		print(outf)
		write.table(file=outf,slist[2:length(slist)],row.names=F,quote=F,col.names=F)
	} 
}

