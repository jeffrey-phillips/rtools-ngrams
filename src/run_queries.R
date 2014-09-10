qbase=paste('./search_prefix ', server_address, sep='')

# Subject-centered query.
# [DT] [JJ] [NN] NN [RB] VB
for (n in nn$concept) {
	outf<-paste('noun_subj/',n,'.txt',sep='')
	q<-paste(qbase, "'", n, "' '(print-ngram (seq (? (tag = DT)) (? (tag ~ [NJ].*)) (and (tag ~ [N].*) (word = ", n, ")) (? (tag ~ [RB].*)) (tag ~ [V].*)))' > ",outf, sep="")
	print(q)
	system(q)
}

# Verb-centered query for subjects.
# [DT] [JJ] [NN] NN [RB] VB
system('mkdir verbs')
for (v in vbset$past) {
	outf<-paste('verbs/',v,'.txt',sep='')
	q<-paste(qbase, "'", v, "' '(print-ngram (seq (? (tag = DT)) (+ (tag ~ [NJ].*)) (? (tag ~ [RB].*)) (tag ~ [V].*)))' > ",outf, sep="")
	print(q)
	system(q)
}	

# Object-centered query.
system('mkdir ~/krns/ngramtools-read-only/noun_obj')
for (n in nn$concept) {
	outf<-paste('noun_obj/',n,'.txt',sep='')
	q<-paste(qbase, "'", n, "' '(print-ngram (seq (tag ~ [V].*) (? (tag ~ [RB].*)) (? (tag = DT)) (? (+ (tag ~ [NJ].*))) (and (tag ~ [N].*) (word = ", n, ")) ))' > ",outf, sep="")
	print(q)
	system(q)
}

# Verb-centered query for objects.
system('mkdir ~/krns/ngramtools-read-only/verb_obj')
for (v in vbset$past) {
	outf<-paste('verb_obj/',v,'.txt',sep='')
	q<-paste(qbase, "'", v, "' '(print-ngram (seq (and (tag ~ [V].*) (word = ", v, ")) (? (tag ~ [RB].*)) (? (tag = DT)) (? (+ (tag ~ [NJ].*))) (tag ~ [N].*)))' > ",outf, sep="")
	print(q)
	system(q)
}	

