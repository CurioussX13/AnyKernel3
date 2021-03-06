#!/system/bin/sh
# Clarity Kernel Tweaks And Parameters

# Allows us to get init-rc-like style
write() { echo "$2" > "$1"; }

# SchedTune Permissions
for group in background foreground rt top-app audio-app; do
         chmod 0644 /dev/stune/$group/*
    done

# SchedTune
write /dev/stune/top-app/schedtune.boost 0

# Thermal Engine (Intelli Thermal v3)
chmod 0644 /sys/module/msm_thermal/parameters/enabled
write /sys/module/msm_thermal/parameters/enabled 1
chmod 0644 /sys/module/msm_thermal/core_control/enabled
write /sys/module/msm_thermal/core_control/enabled 0
chmod 0644 /sys/module/msm_thermal/vdd_restriction/enabled
write /sys/module/msm_thermal/vdd_restriction/enabled 0
write /sys/module/msm_thermal/parameters/core_limit_temp_degC 60
write /sys/module/msm_thermal/parameters/limit_temp_degc 60
write /sys/module/msm_thermal/parameters/temp_threshold 55
write /sys/module/msm_thermal/parameters/poll_ms 1000

# GPU Values
write /sys/class/kgsl/kgsl-3d0/devfreq/governor "msm-adreno-tz"
write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000

# Switch to CFQ I/O scheduler
write /sys/block/mmcblk0/queue/scheduler cfq
write /sys/block/mmcblk1/queue/scheduler cfq

# Battery
write /sys/kernel/fast_charge/force_fast_charge 1

# Disable slice_idle on supported block devices
for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
    write /sys/block/$block/queue/iosched/slice_idle 0
done

# Set read ahead to 128 kb for internal & 512kb for storage
write /sys/block/mmcblk0/queue/read_ahead_kb 128
write /sys/block/mmcblk1/queue/read_ahead_kb 512

# Low Memory Killer
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/process_reclaim/parameters/enable_process_reclaim 0
write /sys/module/lowmemorykiller/parameters/debug_level 0

# Misc Audio Optimizations
write /sys/module/snd_soc_wcd9330/parameters/high_perf_mode 0
write /sys/module/snd_soc_wcd9335/parameters/huwifi_mode 0
write /sys/module/snd_soc_wcd9335/parameters/low_distort_amp 0
write /sys/module/snd_soc_wcd9xxx/parameters/impedance_detect_en 0
