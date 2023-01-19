# Wireguard_wg-ui

## Wg Post Up/Down

```wg.conf
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth+ -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth+ -j MASQUERADE
```
This command is configuring the iptables firewall and router.

- **bold iptables -A FORWARD -i wg0 -j ACCEPT**: This command is appending (-A) a new rule to the FORWARD chain of the iptables firewall. The rule specifies that packets arriving on the interface (-i) named "wg0" should be ACCEPTed (-j ACCEPT) and forwarded to the next rule.
- **bold iptables -A FORWARD -o wg0 -j ACCEPT**: This command is appending a new rule to the FORWARD chain of the iptables firewall. The rule specifies that packets leaving on the interface (-o) named "wg0" should be ACCEPTed (-j ACCEPT) and forwarded to the next rule.
- **bold iptables -t nat -A POSTROUTING -o eth+ -j MASQUERADE**: This command is adding a new rule to the nat table's POSTROUTING chain. The rule specifies that all packets leaving the interface (-o) with name starts with "eth" should be MASQUERADE (-j MASQUERADE), this allows the IP address of the traffic to be changed to that of the router, hence hiding the origin IP.

All of this commands together set up a basic forwarding and NAT rules to allow traffic to flow in and out of the interface wg0 and have it masquerade the traffic leaving through the interface starting with "eth"


https://github.com/ngoduykhanh/wireguard-ui
https://github.com/linuxserver/docker-wireguard