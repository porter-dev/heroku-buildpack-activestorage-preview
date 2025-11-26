class FfmpegController < ApplicationController
  def index
    @ffmpeg_version = get_ffmpeg_version
    @ffprobe_version = get_ffprobe_version
    render plain: build_response
  end

  def info
    render json: {
      ffmpeg: get_ffmpeg_version,
      ffprobe: get_ffprobe_version,
      ffmpeg_path: `which ffmpeg 2>/dev/null`.strip,
      ffprobe_path: `which ffprobe 2>/dev/null`.strip
    }
  end

  private

  def get_ffmpeg_version
    `ffmpeg -version 2>&1`.lines.first&.strip || "FFmpeg not found"
  rescue => e
    "Error: #{e.message}"
  end

  def get_ffprobe_version
    `ffprobe -version 2>&1`.lines.first&.strip || "FFprobe not found"
  rescue => e
    "Error: #{e.message}"
  end

  def build_response
    <<~RESPONSE
      FFmpeg Test App
      ===============

      FFmpeg Version:
      #{@ffmpeg_version}

      FFprobe Version:
      #{@ffprobe_version}

      Visit /ffmpeg/info for JSON output
    RESPONSE
  end
end
