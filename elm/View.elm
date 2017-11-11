module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)

view : Model.Model -> Html Model.Msg
view model =


viewAlertMsg : Maybe String -> Html Model.Msg
viewAlertMsg alertMsg =
  case alertMsg of
    Just message ->
      div [class "alert"]
      [ div [] [text message]
      ]
    Nothing -> text ""

viewQuestionList : List Model.QuestionRecord -> List Int -> Html Model.Msg
viewQuestionList allQuestions questions =
    allQuestions
        |> List.filter (\qRecord -> List.member qRecord.questionUUID questions)
        |> List.map viewQuestionItem
        |> div [ class "questions" ]


viewQuestionItem : Model.QuestionRecord -> Html Model.Msg
viewQuestionItem questionRecord =
    case questionRecord.questionType of
        Model.CheckBox ->
            buildCheckboxQuestion questionRecord

        Model.RadioButton ->
            buildRadioButtonQuestion questionRecord

        Model.TextInput ->
            buildTextInputQuestion questionRecord

        Model.Button ->
            buildButton questionRecord

        Model.NotAQuestion ->
            div []
                [ div [] [ text questionRecord.questionTitle ]
                , div [] [ text questionRecord.questionDescription ]
                ]
        _ ->
            div [] [ text "No QuestionType Error" ]