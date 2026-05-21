### This repo contains useful file loaders and writers for the [Usagi](https://github.com/brettchalupa/usagi) game engine

### Available file loaders:
- [**PPM**](/doc/ppm_loader.md) (image): `RW` 
- **PNG** (image): Planned `RW`
- **NBT** (data): Planned `RW`
- **WAV** (audio): Planned `R`

### Loader structure

Each loader has a `loader.save([filename], args)` and a `loader.load([filename], args)` function.

- Loaded images are represented as a **2D table matrix**
- Loaded sounds are represented as a **table of pitches**, that can be played back at 60sps (sample per second), using any short sound sfx
- Loaded NBT data is stored as a **lua table**