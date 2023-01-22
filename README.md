# Wireguard_wg-ui

This repo contains a wireguard server from LinuxserverIO and a wireguard-ui frontend

The frontend generated all the config files and the wireguard deploys them on change.

IMPORTANT: make sure the ui is not available for non admins.

configuration with a local private key (without transfering the key) is also possible. Just enter the pub key when generating a new client in the ui.

## installation

1. make the .env file
2.  ```sh
    docker compose up -d
    ```
3. change password

## Wg Post Up/Down

```wg.conf
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth+ -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth+ -j MASQUERADE
```
This command is configuring the iptables firewall and router.

- **iptables -A FORWARD -i wg0 -j ACCEPT**: This command is appending (-A) a new rule to the FORWARD chain of the iptables firewall. The rule specifies that packets arriving on the interface (-i) named "wg0" should be ACCEPTed (-j ACCEPT) and forwarded to the next rule.
- **iptables -A FORWARD -o wg0 -j ACCEPT**: This command is appending a new rule to the FORWARD chain of the iptables firewall. The rule specifies that packets leaving on the interface (-o) named "wg0" should be ACCEPTed (-j ACCEPT) and forwarded to the next rule.
- **iptables -t nat -A POSTROUTING -o eth+ -j MASQUERADE**: This command is adding a new rule to the nat table's POSTROUTING chain. The rule specifies that all packets leaving the interface (-o) with name starts with "eth" should be MASQUERADE (-j MASQUERADE), this allows the IP address of the traffic to be changed to that of the router, hence hiding the origin IP.

All of this commands together set up a basic forwarding and NAT rules to allow traffic to flow in and out of the interface wg0 and have it masquerade the traffic leaving through the interface starting with "eth"


https://github.com/ngoduykhanh/wireguard-ui
https://github.com/linuxserver/docker-wireguard