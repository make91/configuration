apps_install:
  pkg.installed:
    - pkgs:
      - curl
      - tree
      - build-essential
      - openjdk-8-jdk
      - git
      - geany

{% if not salt['pkg.version']('nodejs').startswith('8.') %}

node_install:
  cmd.run:
    - name: |
        curl -sL https://deb.nodesource.com/setup_8.x |bash -
        apt-get -y install nodejs

npm@4:
  npm.installed

{% endif %}

react-native-cli:
  npm.installed

{% set user = pillar.get('user', 'xubuntu') %}

{% if not salt['file.directory_exists']('/home/{0}/android-sdk'.format(user)) %}

download_android_sdk:
  file.managed:
    - name: /tmp/sdk-tools.zip
    - source: https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
    - source_hash: sha1=7eab0ada7ff28487e1b340cc3d866e70bcb4286e

extract_android_sdk:
  cmd.run:
    - name: unzip /tmp/sdk-tools.zip -d /home/{{ user }}/android-sdk
    - user: {{ user }}
    - group: {{ user }}

configure_android_sdk:
  cmd.run:
    - user: {{ user }}
    - group: {{ user }}
    - cwd: /home/{{ user }}/android-sdk/tools/bin
    - name: |
        yes | ./sdkmanager --update
        ./sdkmanager "platform-tools" "platforms;android-27" "patcher;v4" "emulator" "build-tools;27.0.3" "extras;android;m2repository"
        yes | ./sdkmanager --licenses

add_android_to_path:
  file.append:
    - name: /home/{{ user }}/.profile
    - source: salt://android-dev/to_path

reminder_to_source:
  cmd.run:
    - name: printf "update path with this command:\nsource ~/.profile\n\n" | write {{ user }}

{% endif %}
