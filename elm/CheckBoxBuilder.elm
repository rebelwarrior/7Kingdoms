module CheckBoxBuilder exposing (buildCheckboxQuestion)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)
-- import Model


-- buildCheckboxQuestion : Model.QuestionRecord -> Html Model.Msg
buildCheckboxQuestion record =
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

        listOfCheckboxes =
            record.questionOptions.optionContent
                |> List.map3 checkboxItem listOfOffCheckOpts listOfOnCheckOpts

        error =
            ((listTotal * 2) /= (List.length record.questionOptions.onClickfn))

        questionID =
            toString record.questionUUID
    in
        if error then
            div [ class "alert" ]
                [ text ("too few options in CheckBox Question Record: " ++ questionID) ]
        else
            div [ class "question" ]
                [ div [ class "checkbox-question", (attribute "uuid" questionID) ] []
                , div [ class "question-text" ] [ text record.questionTitle ]
                , div [ class "question-description" ] [ text record.questionDescription ]
                , fieldset []
                    [ legend [ class "sr-only" ] [ text record.questionTitle ]
                    , ul [ class "unstyled-list" ] listOfCheckboxes
                    ]
                ]


checkboxItem offClickMsg onClickMsg optionName =
    let
        onCheckFn bool =
            if bool then
                onClickMsg
            else
                offClickMsg
    in
        li [ class "checkbox" ]
            [ input
                [ type_ "checkbox"
                , onCheck onCheckFn
                ]
                []
            , label [] [ text optionName ]
            ]
