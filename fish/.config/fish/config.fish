# Path to Oh My Fish install.
set -gx OMF_PATH "/home/kendall/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/kendall/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

eval (thefuck --alias | tr '\n' ';')
eval (thefuck --alias shit | tr '\n' ';')
