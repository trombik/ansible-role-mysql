# ansible-role-mysql

A brief description of the role goes here.

## Known issues

Although `mysql_server_debug`, a role variable to enable or disable certain
log outputs from `ansible`, is available, you should not rely on it because
the role manages contents of various `*.cnf` and other files within loops. It
is possible to disable logs in every loop, but that makes debugging extremely
difficult.

# Requirements

None

# Role Variables

| variable | description | default |
|----------|-------------|---------|


# Dependencies

None

# Example Playbook

```yaml
```

# License

```
Copyright (c) 2021 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>

This README was created by [qansible](https://github.com/trombik/qansible)
