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
