# Datadog-notify

Send a notification event to datadog

[![wercker status](https://app.wercker.com/status/1a04f6bb77117cb68d8031d7a9828296/s "wercker status")](https://app.wercker.com/project/bykey/1a04f6bb77117cb68d8031d7a9828296)

## Options

 - `token` (required) Your Datadog Token
 - `priority` (optional, default: `normal`) The priority of the event we're generating (`low` or `normal`)

## Example

    build:
        after-steps:
            - weyforth/datadog-notify:
                token: $DATADOG_TOKEN
                priority: normal

## License

The MIT License (MIT)
