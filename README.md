# MetalExternalTextureTest

## What's this for?

This is a minimal project reproducing an issue where `GetNativeTexturePtr()` makes Unity Editor/Player unresponsive.

It's originally reported in the KlakSyphon project.
At first, I suspect the Syphon plugin code, but by testing with this minimal project, I figured out the issue is solely caused by `GetNativeTexturePtr()`.
