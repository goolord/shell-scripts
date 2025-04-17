#! /usr/bin/zsh

VST_DIRS=(
    "/mnt/c/Program Files (x86)/Common Files/VST3/"
    "/mnt/c/Program Files/Common Files/VST3/"
    "/mnt/c/Program Files (x86)/Steinberg/VstPlugins/"
    "/mnt/c/Program Files/Steinberg/VstPlugins/"
    "/mnt/c/Program Files (x86)/Common Files/VST2/"
    "/mnt/c/Program Files (x86)/VstPlugins/"
    "/mnt/c/Program Files/Common Files/VST2/"
    "/mnt/c/Program Files/VstPlugins/"
    "/mnt/c/Program Files/Common Files/Steinberg/VST2/"
    "/mnt/c/Program Files/Plogue/"
    "/mnt/c/Program Files/Vstplugins/KV331 Audio/"
    "/mnt/c/Program Files/2C-Audio/"
    "/mnt/c/Program Files/Native Instruments/VSTPlugins 64 bit/"
    "/mnt/f/VSTPlugIns/"
)

# Get the list of used VSTs
USED=("${(@f)$(fd '.*.fst' Effects Generators --format {/})}")

# Get the list of installed VSTs
INSTALLED_VST=("${(@f)$(fd '.*fst' Installed/Effects/VST Installed/Generators --format {/})}")
INSTALLED_VST3=("${(@f)$(fd '.*fst' Installed/Effects/VST3 Installed/Generators/VST3 --format {/})}")

# Create a pattern with word boundaries
USED_PATTERN=()
for ITEM in "${USED[@]}"; do
  USED_PATTERN+=$(printf "(^.*%s$)\n" "$ITEM")
done
USED_PATTERN=${(j:|:)USED_PATTERN}

# Filter unused VSTs
ALL_VST=$(fd . "${VST_DIRS[@]}" -e dll --follow)

UNUSED_VST=("${(@f)$(printf "%s\n" "${INSTALLED_VST[@]}" | rg -v "$USED_PATTERN" | sort -u | sed 's/\.fst$//')}")

for ITEM in "${UNUSED_VST[@]}"; do
  echo "$ALL_VST" | rg "$ITEM.*\.dll$"
done

# Filter unused VST3s
ALL_VST3=$(fd . "${VST_DIRS[@]}" -e vst3 --follow)

UNUSED_VST3=("${(@f)$(printf "%s\n" "${INSTALLED_VST3[@]}" | rg -v "$USED_PATTERN" | sort -u | sed 's/\.fst$//')}")

for ITEM in "${UNUSED_VST3[@]}"; do
  echo "$ALL_VST3" | rg "$ITEM.*\.vst3$"
done
