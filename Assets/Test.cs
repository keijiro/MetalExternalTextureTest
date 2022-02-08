using UnityEngine;
using System.Runtime.InteropServices;
using IntPtr = System.IntPtr;

sealed class Test : MonoBehaviour
{
    [DllImport("Plugin")]
    static extern IntPtr Plugin_CreateTexture(int width, int height);

    [DllImport("Plugin")]
    static extern void Plugin_DestroyTexture(IntPtr pointer);

    const int Width = 256;
    const int Height = 256;

    IntPtr _pointer;
    Texture _texture;

    void Start()
    {
        _pointer = Plugin_CreateTexture(Width, Height);
        _texture = Texture2D.CreateExternalTexture
          (Width, Height, TextureFormat.RGBA32, false, false, _pointer);

        GetComponent<Renderer>().material.mainTexture = _texture;
    }

    void OnDestroy()
    {
        Destroy(_texture);
        Plugin_DestroyTexture(_pointer);
    }

    void Update()
    {
        Debug.Log($"{_pointer}/{_texture.GetNativeTexturePtr()}");
    }
}
