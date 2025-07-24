# Real-ESRGAN Worker for RunPod

This worker provides an API to upscale images using [Real-ESRGAN](https://github.com/xinntao/Real-ESRGAN).

## Input

The input to this worker is:

```json
{
  "input": {
    "data_url": "https://github.com/xinntao/Real-ESRGAN/raw/master/inputs/00003.jpg",
    "model": "RealESRGAN_x4plus",
    "scale": 4,
    "tile": 0,
    "tile_pad": 10,
    "pre_pad": 0,
    "output_type": "individual"
  }
}
```

### Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| data_url | string | URL to the image to upscale |
| model | string | Model to use for upscaling. Options: `RealESRGAN_x4plus`, `RealESRNet_x4plus`, `RealESRGAN_x4plus_anime_6B`, `RealESRGAN_x2plus` |
| scale | float | Scale factor for upscaling |
| tile | int | Tile size for tiled upscaling. 0 for no tiling |
| tile_pad | int | Padding size for tiled upscaling |
| pre_pad | int | Padding size for pre-processing |
| output_type | string | Output type. Options: `individual`, `zip` |

## Output

The output of this worker is a list of URLs to the upscaled images.

## Local Development

```bash
docker build -t esrgan-worker .
docker run -p 8080:8080 esrgan-worker
```