#import <Metal/MTLDevice.h>
#import <Metal/MTLTexture.h>
#import "IUnityGraphicsMetal.h"

static IUnityInterfaces *s_interfaces;
static IUnityGraphicsMetal *s_graphics;

static id<MTLDevice> GetMetalDevice()
{
    if (!s_graphics) s_graphics = UNITY_GET_INTERFACE(s_interfaces, IUnityGraphicsMetal);
    return s_graphics ? s_graphics->MetalDevice() : nil;
}

void UNITY_INTERFACE_EXPORT UNITY_INTERFACE_API UnityPluginLoad(IUnityInterfaces *interfaces)
{
    s_interfaces = interfaces;
}

void UNITY_INTERFACE_EXPORT UNITY_INTERFACE_API UnityPluginUnload(void)
{
    s_interfaces = NULL;
    s_graphics = NULL;
}

id<MTLTexture> Plugin_CreateTexture(int width, int height)
{
    MTLTextureDescriptor* desc = [MTLTextureDescriptor
      texture2DDescriptorWithPixelFormat: MTLPixelFormatRGBA8Unorm
                                   width: width
                                  height: height
                               mipmapped: NO];
    return [GetMetalDevice() newTextureWithDescriptor:desc];
}

void Plugin_DestroyTexture(id<MTLTexture> texture)
{
    [texture release];
}
