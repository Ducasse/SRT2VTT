"
I'm converter from srt to vtt (subtitle for web pluggins).

! Goal
I convert the following contents 

1
00:00:07,040 --> 00:00:10,440
Hello. This week,
we'll get to the heart of the matter,

2
00:00:10 600 --> 00:00:12,160
about syntax especially.

into 

WEBVTT

00:00:07.040 --> 00:00:10.440 align:middle
Hello. This week,
we'll get to the heart of the matter,

00:00:10.600 --> 00:00:12.160 align:middle
about syntax especially.

!! Examples

[[[
SRT2VTT new
	srtFilesInDirectory: FileSystem disk workingDirectory;
	process
]]]

!! Main API
- Converting: once the in and out streams set: go will proceed and launch the conversion.
- srtFilesIn...


"
Class {
	#name : #SRT2VTT,
	#superclass : #Object,
	#instVars : [
		'in',
		'out',
		'currentLine',
		'vttFiles',
		'eraseExistingVTTFiles'
	],
	#classVars : [
		'EndOfLineChar'
	],
	#classInstVars : [
		'in',
		'out'
	],
	#category : #SRT2VTT
}

{ #category : #erase }
SRT2VTT >> doNotEraseExistingVTTFiles [
	self setEraseExistingVTTFiles: false
]

{ #category : #output }
SRT2VTT >> emitAlignMiddle [
	out nextPutAll: ' align:middle'.
	self outGotoLine
]

{ #category : #output }
SRT2VTT >> emitConvertedDuration [
	out nextPutAll: (currentLine copyReplaceAll: ',' with: '.') .

]

{ #category : #converting }
SRT2VTT >> emitCurrentLine [

	out nextPutAll: currentLine.
	self outGotoLine 
]

{ #category : #output }
SRT2VTT >> emitWebVTTLine [
	out nextPutAll: 'WEBVTT'.
	self outGotoLine.
	self outGotoLine
]

{ #category : #erase }
SRT2VTT >> eraseExistingVTTFiles [

	self setEraseExistingVTTFiles: true
]

{ #category : #converting }
SRT2VTT >> go [
	self emitWebVTTLine.
	[ in atEnd ]
		whileFalse: [ self treatOneBlock ]
]

{ #category : #accessing }
SRT2VTT >> in: aStream [
	in := aStream
]

{ #category : #initialization }
SRT2VTT >> initialize [
	super initialize.
	in := '' readStream.
	out := '' writeStream.
	vttFiles := OrderedCollection new.
	self doNotEraseExistingVTTFiles.
	
]

{ #category : #read }
SRT2VTT >> isDurationLine [
	"Returns true if the line starts with anInteger"

	^ currentLine trimRight isAllDigits
]

{ #category : #read }
SRT2VTT >> isEmptyLine [
	"Returns true if the line is empty"

	^  currentLine isEmpty 
]

{ #category : #read }
SRT2VTT >> isIntegerLine [
	"Returns true if the line starts with anInteger"

	^ currentLine trimRight isAllDigits 
	
]

{ #category : #accessing }
SRT2VTT >> out [
	^ out 
]

{ #category : #accessing }
SRT2VTT >> out: aStream [
	out := aStream
]

{ #category : #output }
SRT2VTT >> outGotoLine [
	out nextPut: Character lf
]

{ #category : #files }
SRT2VTT >> process: aFileReference [
	aFileReference isDirectory
		ifTrue: [ self srtFilesInDirectory: aFileReference ]
		ifFalse: [ self processFile: aFileReference ]
]

{ #category : #files }
SRT2VTT >> processFile: aSrtFileReference [
	"'/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/PharoMooc/Subtitles'
		asFileReference
	"
	| vtt rstream wstream |
	vtt := aSrtFileReference withExtension: 'vtt'.
	(vttFiles includes: vtt)
		ifTrue: [ ^ self].
	
	rstream := aSrtFileReference readStream.	
	wstream := FileStream forceNewFileNamed: vtt.
	[ self in: rstream.
	self out: wstream.
	self go] ensure: [ rstream close. wstream close ]
]

{ #category : #read }
SRT2VTT >> readLine [
	"currentLine := in upToAny: {Character cr . Character lf}.
	(in peekBack = Character cr and: [ in peek = Character lf ])
							ifTrue: [ in next ]."
	| line |
	line := (ZnFastLineReader on: in) nextLine.
	currentLine := line ifNil: [ '' ] ifNotNil: [ line ].
	^ currentLine
]

{ #category : #erase }
SRT2VTT >> setEraseExistingVTTFiles: aBoolean [
	eraseExistingVTTFiles := aBoolean
]

{ #category : #files }
SRT2VTT >> srtFilesInDirectory: aPath [
	"self new srtFilesInDirectory: '/Users/ducasse/Library/Application Support/Pharo/images/09-08-2016-PillarDevOn60' asFileReference"
	| srtFiles |
	srtFiles := aPath asFileReference allChildren
		select: [ :each | each extension = 'srt' ].

	"to erase existing vtt files we simply 
	say that none are already existing"
	vttFiles := eraseExistingVTTFiles
		ifTrue: [  #() ]
		ifFalse: [ aPath asFileReference allChildren select: [ :each | each extension = 'vtt' ] ].
	srtFiles do: [ :each | self processFile: each ].
]

{ #category : #converting }
SRT2VTT >> treatOneBlock [

	self readLine.	"This is an integerLine"
	self validateInteger.
	self readLine.	"reading duration"
	self emitConvertedDuration.
	self emitAlignMiddle.	"Now we will produce text line by line."
	[ self readLine.
	in atEnd or: [ self isEmptyLine ]]
		whileFalse: [ self emitCurrentLine ].
	in atEnd ifTrue: [ self emitCurrentLine ].
	self outGotoLine.
	
]

{ #category : #read }
SRT2VTT >> validateInteger [

	[ (Integer readFrom: currentLine) ] on: Error do: [ Stdio stderr nextPutAll: 'Expecting an integer and got instead: ', currentLine ] 
]
