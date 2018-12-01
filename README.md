# libo

libo is short for 'license boilerplates'.  
libo enables to make license texts easily.

## Install

You don't have to do anything if you have perl(>= 5.16.3),  
and don't have to install any modules because libo uses standard modules only.

## Usage

### How to license text dump

```
$ perl libo.pl dump mit
MIT License

Copyright (c) 2018 Hodaka Suzuki


Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

Year and author name is automatically inserted.

### How to available license list

```
$ perl libo.pl list | column
AFL-3.0         BSD-2-Clause        CC-BY-4.0       EPL-1.0         GPL-3.0         LGPL-3.0        MS-PL           PostgreSQL
AGPL-3.0        BSD-3-Clause-Clear  CC-BY-SA-4.0        EUPL-1.1        ISC         LPPL-1.3c       NCSA            Unlicense
Apache-2.0      BSD-3-Clause        CC0-1.0         GPL-1.0         LGPL-2.0        MIT         OFL-1.1         WTFPL
Artistic-2.0        BSL-1.0         ECL-2.0         GPL-2.0         LGPL-2.1        MPL-2.0         OSL-3.0         Zlib
```

If you want to see detail usages, input ` perl libo.pl help `.

## Author

[Hodaka Suzuki](https://github.com/altitude3190)


## Lisense

[MIT](https://github.com/altitude3190/enigma/blob/master/LICENSE)
