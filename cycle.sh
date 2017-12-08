# !/usr/bash

vault unmount ethereum/org/bar
vault delete sys/plugins/catalog/ethereum-plugin
go build
sudo mv vault-ethereum /etc/vault.d/vault_plugins
export SHA256=$(shasum -a 256 "/etc/vault.d/vault_plugins/vault-ethereum" | cut -d' ' -f1)
vault write sys/plugins/catalog/ethereum-plugin \
      sha_256="${SHA256}" \
      command="vault-ethereum --ca-cert=/etc/vault.d/root.crt --client-cert=/etc/vault.d/vault.crt --client-key=/etc/vault.d/vault.key"
 vault mount -path="ethereum/org/bar" -plugin-name="ethereum-plugin" plugin