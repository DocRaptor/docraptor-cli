# DocRaptor CLI

**WARNING: This is a beta client and subject to serious change**

This is a command line interface for using [DocRaptor API](https://docraptor.com/documentation) to convert [HTML to PDF and XLSX](https://docraptor.com).


## Installation

```bash
gem install docraptor-cli
```


## Usage

```bash
docraptor local_file.html                              # local files
docraptor https://docraptor.com/examples/invoice.html  # URLs are detected by prefix
```

The full DocRaptor API is available, see:

```
Usage: docraptor [options] <url/file>

Server options:
    -k, --key KEY                    The API Key to use when calling the service. Defaults to YOUR_API_KEY_HERE or ENV[DOCRAPTOR_API_KEY].
    -s, --server SERVER              Make API requests against SERVER, scheme not required. Defaults to https://docraptor.com

Document options:
        --async                      Create document asynchronously(10 min limit). Defaults to synchronous(1 min limit).
    -d, --debug                      Enable debug logging.
        --no-ignore-resource-errors  Error when a resource cannot be downloaded.
    -j, --javascript                 Enable DocRaptor JavaScript parsing. Defaults to no javascript.
        --name NAME                  Give a name to this document. Defaults to a randomized string. Does not affect output filename.
        --referrer URL               Set HTTP REFERRER when rendering. Defaults to localhost for file rendering or render url.
        --strict STRICTNESS          Set HTML strictness. Defaults to none.
        --test                       Create this as a test document. Defaults to non-test.
    -t, --type TYPE                  Type of document to make, can be pdf, xls, xlsx. Defaults to pdf.

Prince options:
        --prince-baseurl URL         Set base url when rendering. Defaults to nothing for file rendering or render url.
        --prince-css-dpi DPI         Set a base CSS DPI. Defaults value used by Prince is 96.

...
```



We have guides for doing some of the common things:

* [Headers and Footers](https://docraptor.com/documentation/style#pdf-headers-footers) including page skipping
* [CSS Media Selector](https://docraptor.com/documentation/api#api_basic_pdf) to make the page look exactly as it does in your browser
* Protect content with [HTTP authentication](https://docraptor.com/documentation/api#api_http_user) or [proxies](https://docraptor.com/documentation/api#api_http_proxy) so only DocRaptor can access them

## Testing Callbacks

The `--callback-url` option can be used to set a URL that will receive a POST request after your document has successfully been processed. You can simulate this in your *nix development environment using a couple of simple tools: [`nc`](http://linux.die.net/man/1/nc) and [`ngrok`](https://ngrok.com/).

Let's say you had some document content in a file named `test.html`. To test the callback URL, start a new console and type:

```
nc -lk 9001
```

This will listen on port `9001` for requests. Now open another console and type in:
```
ngrok http 9001
```

This will setup an external URL that port forwards to port `9001` on your computer (conveniently being listened to by `nc`). Note the ngrok http URL. It should look something like `http://87654321.ngrok.io`. Copy that URL and open a third console where we will generate our document:
```
bin/docraptor test.html --async --callback_url "http://87654321.ngrok.io"
```

After the document has been generated, if we go to our console running `nc`, we should see we got an HTTP POST request that looks something like this:

```
POST / HTTP/1.1
Connection: close
Host: d94c779c.ngrok.io
Content-Length: 139
Content-Type: application/x-www-form-urlencoded
X-Forwarded-For: 54.158.114.123

download_url=https%3A%2F%2Fdocraptor.com%2Fdownload%2Fe4eabaca-f811-49f8-9375-fcb9cdeae5aa&download_id=e4eabaca-f811-49f8-9375-fcb9cdeae5aa
```

## More Help

DocRaptor has a lot of more [styling](https://docraptor.com/documentation/style) and [implementation options](https://docraptor.com/documentation/api).

Stuck? We're experts at using DocRaptor so please [email us](mailto:support@docraptor.com) if you run into trouble.


## Development

This code is a thin wrapper around the [docraptor gem](https://github.com/docraptor/docraptor-ruby) to make it suitable for command line users.


## Release Process

1. Pull latest master
2. Merge feature branch(es) into master
3. `script/test`
4. Increment version in code:
  - lib/docraptor-cli/version.rb
5. Update [CHANGELOG.md](CHANGELOG.md)
6. Commit "Release vX.Y.Z"
7. `rake release`


## Version Policy

This library follows [Semantic Versioning 2.0.0](http://semver.org).
