#!/bin/bash

SOURCE_DIR="src"

make_all_function()
{
    for file in $SOURCE_DIR/*.hs; do
        echo "Compiling $file..."
        stack exec -- ghc -o "${file%.hs}" "$file"
    done
}

exit_process()
{
    cd bonus
    rm -f $SOURCE_DIR/*.hi $SOURCE_DIR/*.o
    rm $SOURCE_DIR/rotateImg
    rm $SOURCE_DIR/convertImg
    exit
}

bad_value()
{
    whiptail --title "You enter a bad value !" --yes-button "Back to menu" --msgbox "$message" 5 30
}

rotate()
{
    options=$(ls -1 img | grep "\.png$" | awk '{print NR " " $0}')
    selected=$(whiptail --title "Rotator" --menu "Choose a file to rotate" 20 78 10 $options 3>&1 1>&2 2>&3)
    option=$(echo "$options" | grep "^$selected " | awk '{print $2}')
    echo "File is : $option"

    OPTION=$(whiptail --title "Rotator" --menu "Choose the degrees to rotate" 15 50 4 \
        "1" "90" \
        "2" "180" \
        "3" "270" \
        3>&1 1>&2 2>&3)

    degrees="0"

    case $OPTION in
        1) degrees="90";;
        2) degrees="180";;
        3) degrees="270";;
    esac

    filename_output="rotation-$degrees-$option"
    echo "Filename : $filename_output"
    ./bonus/$SOURCE_DIR/rotateImg $degrees img/$option $filename_output
}

convert()
{
    options=$(ls -1 img | awk '{print NR " " $0}')
    selected=$(whiptail --title "Convertor" --menu "Choose a file to convert" 20 78 10 $options 3>&1 1>&2 2>&3)
    option=$(echo "$options" | grep "^$selected " | awk '{print $2}')
    echo "File is : $option"

    OPTION=$(whiptail --title "Convertor" --menu "The image will be convert in this format :" 15 50 4 \
        "1" "png" \
        "2" "jpg" \
        "3" "bmp" \
        "4" "tiff" \
        3>&1 1>&2 2>&3)

    format=""

    case $OPTION in
        1) format="png";;
        2) format="jpeg";;
        3) format="bmp";;
        4) format="tiff";;
    esac

    ./bonus/$SOURCE_DIR/convertImg $format img/$option
}

is_float() {
    local re='^[+-]?[0-9]+([.][0-9]+)?$'
    if [[ $1 =~ $re ]]; then
        return 0
    else
        return 1
    fi
}

compress()
{
    nb_colors=$(whiptail --inputbox "Enter number of colors" 8 39 --title "Enter number of colors" 3>&1 1>&2 2>&3)

    if [[ $? -eq 0 && ! -z $nb_colors ]]; then
        if [[ $nb_colors =~ ^[1-9][0-9]*$ ]]; then
            echo "You have entered a positive number: $nb_colors"
        else
            return
        fi
    else
        return
    fi

    while true; do
    convergence=$(whiptail --inputbox "Enter the convergence" 8 39 --title "Enter the convergence" 3>&1 1>&2 2>&3)
        if is_float "$convergence"; then
            echo "You have entered a float number: $convergence"
            break
        else
            return
        fi
    done

    options=$(ls -1 img | awk '{print NR " " $0}')
    selected=$(whiptail --title "Convertor" --menu "Choose a file to convert" 20 78 10 $options 3>&1 1>&2 2>&3)
    option=$(echo "$options" | grep "^$selected " | awk '{print $2}')
    echo "File is : $option"

    new_path="$option"
    echo "New path: $new_path"

    ./imageCompressor -n $nb_colors -l $convergence -f img/$new_path --graphical
}

leave()
{
    echo "Au revoir !"
    exit_process
}

interface_handler()
{
    cd ..
    ls
    OPTION=$(whiptail --title "Image Compressor" --menu "Choose an option :" 15 50 4 \
        "1" "Rotate Img" \
        "2" "Convert Img" \
        "3" "Compress Img" \
        "4" "Leave" \
        3>&1 1>&2 2>&3)

    case $OPTION in
        1) rotate;;
        2) convert;;
        3) compress;;
        4) leave;;
    esac
}

make_all_function
interface_handler
exit_process
