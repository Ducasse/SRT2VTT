Extension { #name : #AbstractFileReference }

{ #category : #'*SRT2VTT' }
AbstractFileReference >> withoutBasename [
	"Return the receiver without its basename i.e.  '/Users/ducasse/PharoMooc/Subtitles/W1/EN_C019SD-W1-S1.vtt' asFileReference withoutBasename  
-> File @ /Users/ducasse/PharoMooc/Subtitles/W1"

	^ self parent
]

{ #category : #'*SRT2VTT' }
AbstractFileReference >> withoutExtension [
	"Return the receiver without extension i.e.  '/Users/ducasse/PharoMooc/Subtitles/W1/EN_C019SD-W1-S1.vtt' asFileReference withoutExtension  
	File @ /Users/ducasse/PharoMooc/Subtitles/W1/EN_C019SD-W1-S1"

	^ self parent / self basenameWithoutExtension
]
