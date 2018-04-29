cmd-test:
  cmd.run:
    - name: |
        cd /home/xubuntu/.mozilla/firefox
        printf 'user_pref("layout.spellcheckDefault", 0);\nuser_pref("layout.css.devPixelsPerPx", "1.15");\n' >> $(find -maxdepth 1 -type d -name *.default |head -1 |xargs -I path ls path/prefs.js)
