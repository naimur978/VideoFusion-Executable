# 🎬 VideoFusion

**The simplest way to merge videos on macOS**

## 🤔 Why I created this


For my university project, I had a bunch of video clips from different sources—some were phone recordings, others from cameras, and a few screen captures. The problem? They were all separate files, and I needed to put them together into one smooth video for easier sharing and editing.

I tried using online platforms to merge videos, but most of them were either premium, added watermarks, didn't fit my needs, or simply refused to merge large files unless I paid for a subscription. On top of that, some platforms changed the aspect ratio or resolution, so the final video looked weird or cropped. It was frustrating to hit a paywall, see a watermark, or end up with a video that didn’t look right—especially when the file size was just a bit too big for the free tier.

Manually stitching them was a nightmare—jumping between apps, dealing with format issues, syncing problems—it just ate up way too much time. I thought, "There's gotta be a better way."

That's when I decided to make a simple script that could automatically merge different video files, no fuss, no complicated settings. It saves time, handles different formats seamlessly, and gives a clean output ready to share or edit further.

Basically, I made this because I got tired of the hassle and wanted a quick, reliable way to combine videos without losing quality or going crazy.

## ✨ What it does
VideoFusion combines all video files in a folder into one single MP4 file. No technical skills needed - just double-click and done!

## 🎥 Demo
![VideoFusion Demo](VideoFusion_Demo.mov)

*Watch VideoFusion in action - completely silent background operation with macOS notifications*

## 🚀 How to use
1. **Put videos in a folder** (any video format: MP4, MOV, AVI, TS, etc.)
2. **Copy VideoFusion to that folder**
3. **Double-click VideoFusion**
4. **Watch for macOS notifications** - you'll get `output.mp4`

## 📹 Supported formats
- **Input:** MP4, MOV, AVI, MKV, WMV, FLV, WebM, M4V, TS
- **Output:** Always MP4 (best compatibility)

## ⚡ Features
- **Lightning fast** - Uses stream copying when possible
- **High quality** - Preserves original video quality
- **Silent operation** - Runs in background with macOS notifications
- **No Terminal window** - Clean, distraction-free experience
- **Safe** - Asks before overwriting existing files
- **Smart** - Automatically detects all video formats

## 📋 Requirements
- macOS (any version)
- ffmpeg installed (`brew install ffmpeg`)

## 🎯 Example
```
My Videos/
├── VideoFusion
├── vacation_part1.mp4
├── vacation_part2.mov
├── vacation_part3.avi
└── (after running) → output.mp4
```

## 💡 Tips
- Videos are merged in alphabetical order
- Rename files with numbers (01, 02, 03) for specific order
- The tool works in any folder - just copy it where you need it
- Watch for macOS notifications to track progress

---
*Made with ❤️ for simple video merging*
