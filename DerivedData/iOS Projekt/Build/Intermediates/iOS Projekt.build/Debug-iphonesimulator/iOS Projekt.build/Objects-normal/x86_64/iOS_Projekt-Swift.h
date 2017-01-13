// Generated by Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreLocation;
@import CoreData;
@import MapKit;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;
@class NSURL;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSManagedObjectContext;

SWIFT_CLASS("_TtC11iOS_Projekt11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * __nullable window;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
@property (nonatomic, strong) NSURL * __nonnull applicationDocumentsDirectory;
@property (nonatomic, strong) NSManagedObjectModel * __nonnull managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator * __nonnull persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext * __nonnull managedObjectContext;
- (void)saveContext;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class DetailViewController;
@class CLLocation;
@class UIStoryboardSegue;
@class UITableView;
@class NSIndexPath;
@class UITableViewCell;
@class NSManagedObject;
@class NSFetchedResultsController;
@protocol NSFetchedResultsSectionInfo;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC11iOS_Projekt19CestyViewController")
@interface CestyViewController : UITableViewController <CLLocationManagerDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSManagedObjectContext * __nullable managedObjectContext;
@property (nonatomic, strong) DetailViewController * __nullable detailViewController;
@property (nonatomic, copy) NSArray<CLLocation *> * __nullable myLocations;
- (void)viewDidLoad;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (void)saveLocationNil;
- (void)viewWillAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (IBAction)vratitSe:(id __nonnull)sender;
- (NSInteger)numberOfSectionsInTableView:(UITableView * __nonnull)tableView;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (BOOL)tableView:(UITableView * __nonnull)tableView canEditRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)tableView:(UITableView * __nonnull)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)configureCell:(UITableViewCell * __nonnull)cell withObject:(NSManagedObject * __nonnull)object;
@property (nonatomic, readonly, strong) NSFetchedResultsController * __nonnull fetchedResultsController;
@property (nonatomic, strong) NSFetchedResultsController * __nullable _fetchedResultsController;
- (void)controllerWillChangeContent:(NSFetchedResultsController * __nonnull)controller;
- (void)controller:(NSFetchedResultsController * __nonnull)controller didChangeSection:(id <NSFetchedResultsSectionInfo> __nonnull)sectionInfo atIndex:(NSInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type;
- (void)controller:(NSFetchedResultsController * __nonnull)controller didChangeObject:(id __nonnull)anObject atIndexPath:(NSIndexPath * __nullable)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath * __nullable)newIndexPath;
- (void)controllerDidChangeContent:(NSFetchedResultsController * __nonnull)controller;
- (void)saveNewWay:(NSString * __nonnull)nazev teren:(NSString * __nonnull)teren doprava:(NSString * __nonnull)doprava;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class Way;
@class MKMapView;
@protocol MKOverlay;
@class MKOverlayRenderer;
@class UILabel;

SWIFT_CLASS("_TtC11iOS_Projekt20DetailViewController")
@interface DetailViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified dopravaLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified nazevLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified terenLabel;
@property (nonatomic, weak) IBOutlet MKMapView * __null_unspecified mapView;
@property (nonatomic, copy) NSArray<CLLocation *> * __nullable myLocations;
@property (nonatomic, strong) Way * __nullable detailItem;
- (void)configureView;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)vratitZpet:(id __nonnull)sender;
- (void)setupMapView;
- (MKOverlayRenderer * __null_unspecified)mapView:(MKMapView * __null_unspecified)mapView rendererForOverlay:(id <MKOverlay> __null_unspecified)overlay;
- (void)nastavCestu;
- (void)centerMapOnLocation:(CLLocation * __nonnull)location;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11iOS_Projekt6Pozice")
@interface Pozice : NSObject <MKAnnotation>
@property (nonatomic, readonly, copy) NSString * __nullable title;
@property (nonatomic, readonly, copy) NSString * __nullable subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (nonnull instancetype)initWithTitle:(NSString * __nonnull)title subtitle:(NSString * __nonnull)subtitle coordinate:(CLLocationCoordinate2D)coordinate OBJC_DESIGNATED_INITIALIZER;
@end

@class UITextField;

SWIFT_CLASS("_TtC11iOS_Projekt19UdajeViewController")
@interface UdajeViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified nazevTextField;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified terenTextField;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified dopravaTextField;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)vratitZpet:(id __nonnull)sender;
- (IBAction)ulozitUdaje:(id __nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class CLLocationManager;
@class UIButton;
@class UIBarButtonItem;

SWIFT_CLASS("_TtC11iOS_Projekt14ViewController")
@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, weak) IBOutlet MKMapView * __null_unspecified mapView;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified information;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified pressButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem * __null_unspecified zrusButton;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified zadejUdajeButton;
@property (nonatomic, readonly, strong) NSManagedObjectContext * __nonnull managedObjectContext;
@property (nonatomic, strong) CLLocationManager * __null_unspecified locationManager;
@property (nonatomic, copy) NSArray<CLLocation *> * __nonnull myLocations;
@property (nonatomic) BOOL centerOnLocation;
- (void)viewDidLoad;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (void)didReceiveMemoryWarning;
- (IBAction)startAction:(UIButton * __nonnull)sender;
- (IBAction)zobrazitCesty:(id __nonnull)sender;
- (void)setupLocationManager;
- (void)setupMapView;
- (void)locationManager:(CLLocationManager * __nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * __nonnull)locations;
- (MKOverlayRenderer * __null_unspecified)mapView:(MKMapView * __null_unspecified)mapView rendererForOverlay:(id <MKOverlay> __null_unspecified)overlay;
- (void)centerMapOnLocation:(CLLocation * __nonnull)location;
- (IBAction)resetCesty:(id __nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSEntityDescription;

SWIFT_CLASS("_TtC11iOS_Projekt3Way")
@interface Way : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * __nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * __nullable)context OBJC_DESIGNATED_INITIALIZER;
@end

@class NSData;

@interface Way (SWIFT_EXTENSION(iOS_Projekt))
@property (nonatomic, copy) NSString * __nullable doprava;
@property (nonatomic, copy) NSString * __nullable nazev;
@property (nonatomic, copy) NSString * __nullable teren;
@property (nonatomic, strong) NSData * __nullable location;
@end

#pragma clang diagnostic pop