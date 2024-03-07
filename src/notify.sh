#!/bin/bash

TELEGRAM_BOT_TOKEN=6895299881:AAEpKpKrPNq-7DwAj1XgikQToqis58rGYR4
TELEGRAM_USER_ID=1228384051

TIME="10"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"

STATUS=🌽

if [ "$CI_JOB_STATUS" = "success" ]
then
  STATUS="✅"
elif [ "$CI_JOB_STATUS" = "failed" ]
then
  STATUS="❌"
fi

TEXT="Stage: $CI_JOB_STAGE%0AStatus: $CI_JOB_STATUS $STATUS%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"


curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null