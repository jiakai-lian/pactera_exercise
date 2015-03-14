//
//  Common.h
//  pactera_exercise
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#ifndef pactera_exercise_Common_h
#define pactera_exercise_Common_h

//enhanced logging
#ifdef DEBUG
#   define LOG(fmt, ...) NSLog((@"\n\n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define LOG(...)
#endif



#endif
