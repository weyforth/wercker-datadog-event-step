# Datadog-notify

Send a notification event to datadog

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
