import boto3
import json

comprehend = boto3.client('comprehend')

def lambda_handler(event, context):
    # Get the user's input from the Lex bot
    user_input = event['inputTranscript']

    # Call Comprehend to analyze the sentiment or classify the text
    response = comprehend.detect_sentiment(
        Text=user_input,
        LanguageCode='en'
    )

    # Get the sentiment score or classification result
    sentiment_score = response['SentimentScore']
    # or classification_result = response['Classes']

    # Return the result to the Lex bot
    return {
        'dialogAction': {
            'type': 'Close',
            'fulfillmentState': 'Fulfilled',
            'message': {
                'contentType': 'PlainText',
                'content': f'Sentiment score: {sentiment_score}'
            }
        }
    }