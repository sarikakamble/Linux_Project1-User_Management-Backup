#!/bin/bash

backup(){

	clear
	echo "Backup Manegament...!"
	echo ""
	echo "b - Backup...!"
        echo ""
        echo "h - Back To Home Page "
        echo ""
        echo "e - Exit"
	echo ""
        read -p "What do you want to do:  " choice

        case $choice in
                "b" )
                        echo "Backup...!"
                        user_backup
                        ;;
                "h" )
                        clear
                        ./user.sh
                        ;;
                "e" )
			clear
                        exit
                        ;;
	esac
}

user_backup(){
	clear
	echo "which directory backup you want...!"
	echo ""
	read -p "Please enter source path : " src_dir
	echo ""
	read -p "Please enter target path : " tgt_dir


	backup_date="back_$(date +%Y-%m-%d-%H-%M-%S).tar.gz"

	echo "Backup Started...!"

	tar -cvf "${tgt_dir}/${backup_date}" --absolute-names  "$src_dir"

	echo "Backup Completed...!"

}

backup
