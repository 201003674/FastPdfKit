//
//  MFSearchOperation.m
//  FastPDFKitTest
//
//  Created by Nicolò Tosi on 10/21/10.
//  Copyright 2010 MobFarm S.r.l. All rights reserved.
//

#import "TextSearchOperation.h"
#import "MFDocumentManager.h"

@implementation TextSearchOperation
@synthesize page, searchTerm, delegate, document;
@synthesize profile;
@synthesize exactMatch, ignoreCase;

-(void)main 
{	
	// Allocate an autorelease pool.
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	// Get the result from the document.
    
    NSArray *searchResult = [[document searchResultOnPage:page 
                                           forSearchTerms:searchTerm 
                                               ignoreCase:ignoreCase 
                                               exactMatch:exactMatch]copy];
    
	if(![self isCancelled]) 
    {
		if([delegate respondsToSelector:@selector(handleSearchResult:)])
			[(NSObject *)delegate performSelectorOnMainThread:@selector(handleSearchResult:) withObject:searchResult waitUntilDone:YES];
	}
	
	// Cleanup.
	
	[searchResult release];
	[pool release];
}

-(void)dealloc 
{	
	delegate = nil;
	
    MF_COCOA_RELEASE(searchTerm);
    MF_COCOA_RELEASE(document);
    
	[super dealloc];
}

@end
