# CNAME Lookup Script

Discover CNAME (Canonical Name) records for domains with style using this simple Bash script. Whether you need to perform single domain queries or bulk lookups for a list of domains, this script has you covered.

## Usage

```bash
chmod +x cname.sh
```
```
./cname.sh [-l <list_file> | -d <single_domain>] [-o <output_file>]
```
# Examples

### Single Domain Lookup
```
./cname.sh -d example.com
```
### List of Domains Lookup
```
./cname.sh -l subdomains.txt -o cnames.txt
```
## Requirements

- Bash
- `dig` command (typically available on Linux systems)
