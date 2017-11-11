module RadioButtonBuilder exposing (buildRadioButtonQuestion)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on)
-- import Model


-- buildRadioButtonQuestion : Model.QuestionRecord -> Html Model.Msg
buildRadioButtonQuestion record =
    let
        listTotal =
            record.questionOptions.optionContent
                |> List.length

        listOfOnCheckOpts =
            record.questionOptions.onClickfn
                |> List.take listTotal

        listOfOffCheckOpts =
            record.questionOptions.onClickfn
                |> List.drop listTotal


        error =
            ((listTotal * 2) /= (List.length record.questionOptions.onClickfn))

        questionID =
            toString record.questionUUID

        listOfRadioButtons =
            record.questionOptions.optionContent
                |> List.map2 radiobutton record.questionOptions.onClickfn
    in
      if error then
          div [ class "alert" ]
              [ text ("too few options in Radio Button Question Record: " ++ questionID) ]
      else
        div [ class "question" ]
            [ div [ class "radiobutton-question", (attribute "uuid" questionID) ] []
            , div [ class "question-text" ] [ text record.questionTitle ]
            , div [ class "question-description" ] [ text record.questionDescription ]
            , fieldset [ class "fieldset-inputs" ]
                [ legend [ class "sr-only" ] [ text record.questionTitle ]
                , ul [ class "unstyled-list" ] listOfRadioButtons
                ]
            ]


radiobutton onClickFn optionName =
    let
        onClickMsg =
            Model.None
    in
       li [ class "radio" ]
           [
            input
              [ type_ "radio"
              , id optionName
              , name optionName
              , value optionName
              ] [text optionName]
            , label [] [ text optionName ]
           ]