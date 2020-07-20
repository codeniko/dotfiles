alias vim='vim -O'
alias vimp='vim -p'
alias tmux='tmux -2'
alias vimupdate='vim +BundleInstall +qall'
alias timedig='time dig ${1}'

# Only use ifconfig from /sbin/
alias ifconfig='/sbin/ifconfig'

# alias emu="${HOME}/Library/Android/sdk/tools/emulator -avd Nexus_6_API_16_4_1 -gpu on -no-boot-anim -scale 0.26"
# alias emu43="${HOME}/Library/Android/sdk/tools/emulator -avd Nexus_6_API_18_FB_4_3 -gpu on -no-boot-anim -scale 0.26"
# alias emu442="${HOME}/Library/Android/sdk/tools/emulator -avd Nexus_6_API_19_4_4_2 -gpu on -no-boot-anim -scale 0.26"
# alias mountvm="sshfs -p 22 nikolay@host:/home/nikolay/ ~/vm -oauto_cache,reconnect,defer_permissions,noappledouble,volname=vm_host"


# Tex
alias updateTexHome="mktexlsr; updmap-sys; mktexlsr; texhash ${TEXMFHOME}"

# Json
alias prettyJson='python -m json.tool'

# C and GCC
alias valgrind='valgrind --leak-check=full --show-reachable=yes'

# Java, Scala, and SBT
alias sbt-clean-dep='rm -rf ~/.sbt ~/.ivy2'

# Kotlin
alias kotlin-repl='kotlinc-jvm'
