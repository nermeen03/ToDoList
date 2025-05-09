//
//  UserDefaultMethods.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import "UserDefaultMethods.h"

@implementation UserDefaultMethods

+ (NSMutableArray<List *> *)getToDo {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSData *saved = [def objectForKey:@"toDo"];
    
    if (!saved) {
        return [NSMutableArray array];
    }

    NSSet *set = [NSSet setWithObjects:[NSMutableArray class], [List class], nil];
    NSMutableArray<List *> *arr = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:saved error:&error];

    if (error) {
        NSLog(@"Unarchiving error: %@", error);
    }

    return arr ?: [NSMutableArray array];
}


+ (NSMutableArray<List *> *)getDoing {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSData *saved = [def objectForKey:@"doing"];
    
    if (!saved) {
        return [NSMutableArray array];
    }

    NSSet *set = [NSSet setWithObjects:[NSMutableArray class], [List class], nil];
    NSMutableArray<List *> *arr = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:saved error:&error];

    if (error) {
        NSLog(@"Unarchiving error: %@", error);
    }

    return arr ?: [NSMutableArray array];
}
+ (NSMutableArray<List *> *)getDone {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSData *saved = [def objectForKey:@"done"];
    
    if (!saved) {
        return [NSMutableArray array];
    }

    NSSet *set = [NSSet setWithObjects:[NSMutableArray class], [List class], nil];
    NSMutableArray<List *> *arr = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:saved error:&error];

    if (error) {
        NSLog(@"Unarchiving error: %@", error);
    }

    return arr ?: [NSMutableArray array];
}

+(void) setToDo:(NSMutableArray*) data{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
    [def setObject:savedData forKey:@"toDo"];
}
+(void) setDoing:(NSMutableArray*) data{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
    [def setObject:savedData forKey:@"doing"];
}
+(void) setDone:(NSMutableArray *)data{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
    [def setObject:savedData forKey:@"done"];
}
@end
