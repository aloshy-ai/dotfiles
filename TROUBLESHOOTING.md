# Troubleshooting

```sh
error: Nix daemon disconnected unexpectedly (maybe it crashed?)
```

```fix
sudo rm /etc/ssl/certs/ca-certificates.crt
sudo ln -s /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
sudo launchctl kickstart -k system/org.nixos.nix-daemon
```

---

```sh
warning: ignoring the client-specified setting 'build-users-group', because it is a restricted setting and you are not a trusted user
```

TODO: Update `aloshy` with your username

```fix
sudo sed -i '' '/trusted-users/d' /etc/nix/nix.conf
sudo echo "trusted-users = aloshy" >> /etc/nix/nix.conf
sudo launchctl kickstart -k system/org.nixos.nix-daemon
```

---

