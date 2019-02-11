# cgreen010-sophos
based off
Malice Sophos AntiVirus Plugin


### Dependencies

-  centos7

## Installation

1. Install [Docker](https://www.docker.io/).
2. Download [trusted build](https://hub.docker.com/r/malice/sophos/) from public [DockerHub](https://hub.docker.com): `docker pull malice/sophos`

## Usage

```
docker run --rm cgreen010/sophos-centos7 EICAR
```

### Or link your own malware folder:

```bash
$ docker run --rm -v /path/to/malware:/malware:ro cgreen010/sophos-centos7 FILE

Usage: sophos [OPTIONS] COMMAND [arg...]

Malice Sophos AntiVirus Plugin

Version: v0.1.0, BuildTime: 20180903

Author:
  blacktop - <https://github.com/blacktop>

Options:
  --verbose, -V          verbose output
  --elasticsearch value  elasticsearch url for Malice to store results [$MALICE_ELASTICSEARCH_URL]
  --table, -t            output as Markdown table
  --callback, -c         POST results to Malice webhook [$MALICE_ENDPOINT]
  --proxy, -x            proxy settings for Malice webhook endpoint [$MALICE_PROXY]
  --timeout value        malice plugin timeout (in seconds) (default: 60) [$MALICE_TIMEOUT]
  --help, -h             show help
  --version, -v          print the version

Commands:
  update  Update virus definitions
  web     Create a Sophos scan web service
  help    Shows a list of commands or help for one command

Run 'sophos COMMAND --help' for more information on a command.
```

This will output to stdout and POST to malice results API webhook endpoint.

## Sample Output

### [JSON](https://github.com/malice-plugins/sophos/blob/master/docs/results.json)

```json
{
  "sophos": {
    "infected": true,
    "result": "EICAR-AV-Test",
    "engine": "5.27.0",
    "database": "5.35",
    "updated": "20170123"
  }
}
```

### [Markdown](https://github.com/malice-plugins/sophos/blob/master/docs/SAMPLE.md)

---

#### Sophos

| Infected | Result        | Engine | Updated  |
| -------- | ------------- | ------ | -------- |
| true     | EICAR-AV-Test | 5.27.0 | 20170123 |

---

## Documentation

- [To write results to ElasticSearch](https://github.com/malice-plugins/sophos/blob/master/docs/elasticsearch.md)
- [To create a Sophos scan micro-service](https://github.com/malice-plugins/sophos/blob/master/docs/web.md)
- [To post results to a webhook](https://github.com/malice-plugins/sophos/blob/master/docs/callback.md)
- [To update the AV definitions](https://github.com/malice-plugins/sophos/blob/master/docs/update.md)

## Issues

Find a bug? Want more features? Find something missing in the documentation? Let me know! Please don't hesitate to [file an issue](https://github.com/malice-plugins/sophos/issues/new).

## CHANGELOG

See [`CHANGELOG.md`](https://github.com/malice-plugins/sophos/blob/master/sophos/CHANGELOG.md)

## Contributing

[See all contributors on GitHub](https://github.com/malice-plugins/sophos/graphs/contributors).

Please update the [CHANGELOG.md](https://github.com/malice-plugins/sophos/blob/master/sophos/CHANGELOG.md) and submit a [Pull Request on GitHub](https://help.github.com/articles/using-pull-requests/).

### License

MIT Copyright (c) 2016 **blacktop**
