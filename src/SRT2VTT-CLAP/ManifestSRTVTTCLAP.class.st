"
""./pharo clap.image clap srt2vtt --recursive world""
(ClapCommand withName: 'srt2vtt')
	addFlag: (ClapFlag withName: 'recursive');
	addFlag: (ClapFlag withName: 'eraseExisting');
	addPositional: ((ClapPositional withName: 'path') defaultMeaning: [  ];
	meaning: [ :args |
		| eraseExisting |
		eraseExisting := (args atName: 'eraseExisting') value.
		(args atName: 'file') value ifNotNil:
			[ self new
					setEraseExistingVTTFiles: eraseExisting;
					processFile: FileSystem disk workingDirectory, (args atName: 'file') value ].
		(args atName: 'folder') value ifNotNil:
			[ self new
					setEraseExistingVTTFiles: eraseExisting;
					srtFilesInDirectory: FileSystem disk workingDirectory, (args atName: 'folder') value ] ]

"
Class {
	#name : #ManifestSRTVTTCLAP,
	#superclass : #PackageManifest,
	#category : #'SRT2VTT-CLAP'
}
