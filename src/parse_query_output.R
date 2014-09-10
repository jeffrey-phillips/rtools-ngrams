# Read in some pre-processed query results and parse them.

# For noun_subj queries.
setwd('~/krns/ngramtools-read-only/noun_subj')
nounfreq<-data.frame()
for (f in Sys.glob('*txt')) {
	w<-gsub('.txt','',f)
	df<-readLines(con=f)
	tot<-0
	for (i in 1:length(df)) {
		l<-df[i]
		l<-unlist(strsplit(x=l,split=' '))
		l<-l[grepl('\\|',l) & grepl('NN',l) & grepl('VBD',l)]
		for (x in l) {
			x<-unlist(strsplit(x,'\\|'))
			tot<-tot+as.numeric(x[length(x)])
		}
	}
	tmp<-data.frame(word=w,freq=tot)
	nounfreq<-rbind(nounfreq,tmp)
}

# For verb (subj) queries.
setwd('~/krns/ngramtools-read-only/verbs')
verbfreq<-data.frame()
for (f in Sys.glob('*txt')) {
	w<-gsub('.txt','',f)
	df<-readLines(con=f)
	tot<-0
	for (i in 1:length(df)) {
		l<-df[i]
		l<-unlist(strsplit(x=l,split=' '))
		l<-l[grepl('\\|',l) & grepl('NN',l) & grepl('VBD',l)]
		for (x in l) {
			x<-unlist(strsplit(x,'\\|'))
			tot<-tot+as.numeric(x[length(x)])
		}
	}
	tmp<-data.frame(word=w,freq=tot)
	verbfreq<-rbind(verbfreq,tmp)
}

# For noun_obj queries.
setwd('~/krns/ngramtools-read-only/noun_obj')
qpreproc()
nobjfreq<-data.frame()
for (f in Sys.glob('*txt')) {
	w<-gsub('.txt','',f)
	df<-readLines(con=f)
	tot<-0
	for (i in 1:length(df)) {
		l<-df[i]
		l<-unlist(strsplit(x=l,split=' '))
		l<-l[grepl('\\|',l) & grepl('NN',l) & grepl('VBD',l)]
		for (x in l) {
			x<-unlist(strsplit(x,'\\|'))
			tot<-tot+as.numeric(x[length(x)])
		}
	}
	tmp<-data.frame(word=w,freq=tot)
	nobjfreq<-rbind(nobjfreq,tmp)
}

# For verb-centered object queries.
# Verb frequency should correlate with verb frequency from subject queries.
setwd('~/krns/ngramtools-read-only/verb_obj')
qpreproc()
vobjfreq<-data.frame()
for (f in Sys.glob('*txt')) {
	v<-gsub('.txt','',f)
	df<-readLines(con=f)
	tot<-0
	for (i in 1:length(df)) {
		l<-df[i]
		l<-unlist(strsplit(x=l,split=' '))
		l<-l[grepl('\\|',l) & grepl('NN',l) & grepl('VBD',l)]
		for (x in l) {
			x<-unlist(strsplit(x,'\\|'))
			tot<-tot+as.numeric(x[length(x)])
		}
	}
	tmp<-data.frame(word=v,freq=tot)
	vobjfreq<-rbind(vobjfreq,tmp)
}

