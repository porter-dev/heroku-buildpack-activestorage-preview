Rails.application.routes.draw do
  root "ffmpeg#index"
  get "ffmpeg/info", to: "ffmpeg#info"
end
