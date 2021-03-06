if [ ! -n "$WERCKER_DATADOG_NOTIFY_TOKEN" ]; then
  error 'Please specify token property'
  exit 1
fi

if [ ! -n "$WERCKER_DATADOG_NOTIFY_PRIORITY" ]; then
  error 'Please specify priority property'
  exit 1
fi

TITLE="$WERCKER_APPLICATION_OWNER_NAME/$WERCKER_APPLICATION_NAME"

if [ "$DEPLOY" == "true" ]
then
  MESSAGE="[Deploy]($WERCKER_DEPLOY_URL)"
  PIPELINE="deploy"
else
  MESSAGE="[Build]($WERCKER_BUILD_URL)"
  PIPELINE="build"
fi

MESSAGE="$MESSAGE $WERCKER_RESULT"

if [ "$WERCKER_RESULT" == "passed" ]
then
  ALERT_TYPE="success"
else
  ALERT_TYPE="error"
  MESSAGE="$MESSAGE at step *$WERCKER_FAILED_STEP_DISPLAY_NAME*"
fi

curl  -X POST -H "Content-type: application/json" \
-d "{
      \"title\": \"$TITLE\",
      \"text\": \"%%% \n $MESSAGE \n %%%\",
      \"priority\": \"$WERCKER_DATADOG_NOTIFY_PRIORITY\",
      \"alert_type\": \"$ALERT_TYPE\",
      \"tags\": [
        \"ci:wercker\",
        \"pipeline:$PIPELINE\",
        \"app_owner:$WERCKER_APPLICATION_OWNER_NAME\",
        \"app_name:$WERCKER_APPLICATION_NAME\",
        \"started_by:$WERCKER_STARTED_BY\",
        \"result:$WERCKER_RESULT\",
        \"git_owner:$WERCKER_GIT_OWNER\",
        \"git_repo:$WERCKER_GIT_REPOSITORY\",
        \"git_commit:$WERCKER_GIT_COMMIT\",
        \"git_branch:$WERCKER_GIT_BRANCH\",
        \"git_domain:$WERCKER_GIT_DOMAIN\"
      ],
      \"source_type_name\": \"my apps\"
  }" \
"https://app.datadoghq.com/api/v1/events?api_key=$WERCKER_DATADOG_NOTIFY_TOKEN"

#
# \"build_url:            $WERCKER_APPLICATION_URL\",
# \"build_url:            $WERCKER_BUILD_URL\",
# \"run_url:              $WERCKER_RUN_URL\",
# \"git_owner:            $WERCKER_GIT_OWNER\",
# \"git_repo:             $WERCKER_GIT_REPOSITORY\",
# \"git_commit:           $WERCKER_GIT_COMMIT\",
# \"git_branch:           $WERCKER_GIT_BRANCH\",
# \"git_domain:           $WERCKER_GIT_DOMAIN\",
# \"started_by:           $WERCKER_STARTED_BY\",
# \"result:               $WERCKER_RESULT\",
# \"deploy_url:           $WERCKER_DEPLOY_URL\",
# \"deploytarget_name:    $WERCKER_DEPLOYTARGET_NAME\"
