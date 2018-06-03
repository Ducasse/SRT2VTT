"
pharo /Users/ducasse/Documents/Pharo/images/2018-05-30-SRT/2018-05-30-SRT.image clap srt2vtt ES_C019SD-W2-S11.srt
"
Class {
	#name : #SRT2VTTCommandLine,
	#superclass : #Object,
	#category : #'SRT2VTT-CLAP'
}

{ #category : #'command line' }
SRT2VTTCommandLine class >> clap [
	<commandline>
	
	^ (ClapCommand withName: 'srt2vtt')
		addFlag: (ClapFlag withName: 'eraseExisting');
		addPositional: ((ClapPositional withName: 'path') defaultMeaning: [ '.' ]);
		"when there is no positional, we take the current directory"
		
		meaning: [ :args |
			SRT2VTT new
					setEraseExistingVTTFiles: (args atName: 'eraseExisting') value;
					process: (FileSystem disk workingDirectory resolve: (args atName: 'path') value)
					]

]
