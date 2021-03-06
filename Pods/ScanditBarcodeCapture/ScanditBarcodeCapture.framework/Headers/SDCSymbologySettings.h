/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2017- Scandit AG. All rights reserved.
 */

#import <Foundation/Foundation.h>

#import <ScanditCaptureCore/SDCBase.h>
#import <ScanditBarcodeCapture/SDCSymbology.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Settings specific to a particular barcode symbology.
 */
NS_SWIFT_NAME(SymbologySettings)
SDC_EXPORTED_SYMBOL
@interface SDCSymbologySettings : NSObject

/**
 * The symbology that this symbology settings affect.
 */
@property (nonatomic, readonly) SDCSymbology symbology;
/**
 * By default decoding of all symbologies is disabled. To enable decoding of a symbology, set this property to YES. It is advised to only enable symbologies that are required by the application as every enabled symbology adds processing overhead.
 *
 * This property only enables decoding of dark codes on bright background. If color-inverted (bright on dark) codes for this symbology are required, enable them by changing the colorInvertedEnabled property.
 */
@property (nonatomic, assign, getter=isEnabled) BOOL enabled NS_SWIFT_NAME(isEnabled);
/**
 * Determines whether decoding of color-inverted (bright on dark) codes for this symbology is enabled. By default, decoding of color inverted codes is disabled. Currently, the enabled property will also have to be set to YES for bright on dark codes to be scanned, though this may change in a future release.
 */
@property (nonatomic, assign, getter=isColorInvertedEnabled)
    BOOL colorInvertedEnabled NS_SWIFT_NAME(isColorInvertedEnabled);
/**
 * Set of optional checksums to be used for this symbology. The code is accepted if any of the checksums matches in addition to any mandatory checksum of the symbology.
 */
@property (nonatomic, assign) SDCChecksum checksums;
/**
 * The set of enabled extensions of this symbology. Extensions allow to configure features that are specific to a small number of symbologies. For example, there is an extension to configure how to treat the leading zero for UPC-A codes. For a list of supported extensions, refer to Symbology Extensions.
 */
@property (nonatomic, nonnull, readonly) NSSet<NSString *> *enabledExtensions;
/**
 * This property determines the active symbol counts of the symbology, e.g. the supported length of barcodes to be decoded. Change this property to include symbol counts that are not enabled by default, or to optimize decoding performance for a certain number of symbols.
 *
 * The mapping from characters to symbols is symbology-specific. For some symbologies, the start and end characters are included, others include checksums characters in the symbol counts.
 *
 * The active symbol count setting is ignored for fixed-size barcodes (the EAN and UPC family of codes) as well as 2d codes. For other symbologies, refer to Configuring the Active Symbol Count.
 */
@property (nonatomic, strong) NSSet<NSNumber *> *activeSymbolCounts;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * Activate/Deactivate a custom extension for the symbology.
 */
- (void)setExtension:(NSString *)extension
             enabled:(BOOL)enabled NS_SWIFT_NAME(set(extension:enabled:));

@end

NS_ASSUME_NONNULL_END
