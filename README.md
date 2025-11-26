# ActiveStorage Preview Cloud Native Buildpack

A [Cloud Native Buildpack](https://buildpacks.io/) that installs FFmpeg for Rails [Active Storage previews](https://guides.rubyonrails.org/active_storage_overview.html#previewing-files) of video files.

## Usage

### With pack CLI (Local Development)

```bash
pack build my-app \
  --buildpack porter-dev/activestorage-preview \
  --builder heroku/builder:24
```

### With project.toml

Create a `project.toml` in your app root:

```toml
[_]
schema-version = "0.2"

[[io.buildpacks.group]]
id = "porter-dev/activestorage-preview"
uri = "https://github.com/porter-dev/heroku-buildpack-activestorage-preview/releases/download/v1.0.0/activestorage-preview.cnb"

# Add your main buildpack after
[[io.buildpacks.group]]
id = "heroku/ruby"
```

### From GitHub Release

Download the `.cnb` file from the [releases page](https://github.com/porter-dev/heroku-buildpack-activestorage-preview/releases) and use it directly:

```bash
pack build my-app \
  --buildpack ./activestorage-preview.cnb \
  --buildpack heroku/ruby \
  --builder heroku/builder:24
```

## Verification

After building, verify FFmpeg is installed:

```bash
docker run --rm my-app which ffmpeg
# Output: /layers/porter-dev_activestorage-preview/ffmpeg/bin/ffmpeg

docker run --rm my-app ffmpeg -version
```

## FFmpeg Version

| Architecture | FFmpeg Version |
|--------------|---------------:|
| amd64        | 7.1.2          |
| arm64        | 7.1.2          |

## Development

### Building Locally

```bash
# Build a test image
pack build test-app \
  --buildpack . \
  --builder heroku/builder:24 \
  --trust-builder

# Verify installation
docker run --rm test-app ffmpeg -version
```

### Packaging

```bash
pack buildpack package activestorage-preview.cnb --format file
```

### Binaries

Instructions for building FFmpeg binaries can be found in [build/README.md](build/README.md).

## Migration from Classic Buildpack

This is the Cloud Native Buildpack version. Key differences:

- Uses CNB layer system instead of `.heroku/` directory
- Automatic PATH management (no `.profile.d` scripts)
- Built-in caching via layer metadata
- Multi-architecture support (amd64 and arm64)

## License

MIT
