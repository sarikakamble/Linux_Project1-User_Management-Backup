#!/bin/bash

home_page(){
	clear
	echo "Home Page"
	echo ""
	echo "u - User management....!"
	echo "g - Group management....!"
	echo "b - Backup management....!"
	echo "e - Exit"
	echo ""

	read -p  "Please select what you want(u/g/b) : " input
	clear
	

	case $input in
		"u" )
			user_management
			;;
		"g" )
			./group.sh
			;;
		"b" )
			./backup.sh
			;;
		"e" )
			exit
			;;
		esac
}

user_management(){
	clear
	echo "User Management....!"
	echo ""
	echo ""
	echo "c - Create user....!"
	echo ""
	echo "p - Set password for created user....!"
	echo ""
	echo "m - Modify user....!"
	echo ""
	echo "d - Delete user....!"
	echo ""
	echo "s - Show created user....!"
	echo ""
	echo "h - Back to home....!"
	echo ""
	echo "e - Exit"
	echo ""

	read -p  "What do you want to do : " input
	
	case $input in
		"c" )
			create_user
			;;
		"p" )
			set_pass
			;;
		"m" ) 
			modify_user
			;;
		"d" )
			delete_user
			;;
		"s" )
			show_user
			;;
		"h" )
			home_page
			;;
		"e" )
			exit
			;;
		esac
}
		
create_user(){
	clear
	echo "User Creation....!"
	echo ""
	read -p "Please enter your user name : " user_name

	if id "$user_name" &>/dev/null; 
	then
		echo "User $user_name is already exist....!"
		echo ""
	else
		sudo useradd $user_name
		echo "User $user_name is successfully created...!"
		echo ""
	fi

	echo "x - Back to user management"
	echo ""
	echo "h - Back to home"
	echo ""
	echo "e - Exit"
	echo ""

	read -p "Please enter your choice : " choice	
	
	case $choice in
		"x" )
			user_management
			;;
		"h" ) 
			home_page
			;;
		"e" )
		        clear	
			exit
			;;
	esac		
}

set_pass(){
	clear
	echo "Set the password for user....!"
	echo ""
        read -p "Please enter your user name : " user_name
	echo ""

	password_field=$(grep "^$user_name:" /etc/shadow | cut -d: -f2)
	
	if [ -n "$password_field" ];
	then 
		echo "Already password is set for user $user_name"
	else
		sudo passwd $user_name
	fi


	echo ""
	echo "x - Back to user management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
	 read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        user_management
                        ;;
                "h" )
                        home_page
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac


}

modify_user(){
	clear
	echo "Modify user....!"
	echo ""

	read -p "Enter old user name : " old_user

	if id "$old_user" &>/dev/null;
	then
		read -p "Enter new user name : " new_user
		sudo usermod -l $new_user $old_user
		echo ""
		echo "User name as changed successfully...!"
		sudo cat /etc/passwd | grep $new_user
		echo ""
	else
		echo "User $old_user is not found"
		echo ""
	fi

	echo "x - Back to user management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
        read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        user_management
                        ;;
                "h" )
                        home_page
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac	
}	

delete_user(){
	clear
	echo "Delete the user....!"
	echo ""
	
	read -p "Please enter user name : " user_name

        if id "$user_name" &>/dev/null;
        then
		echo ""
		sudo userdel $user_name
                echo "User $user_name is successfully deleted...!"
                echo ""
                
	else
		echo ""
                echo "User $user_name is not found...!"
                echo ""
        fi

	echo "x - Back to user management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
 	read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        user_management
                        ;;
                "h" )
                        home_page
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac

}

show_user(){
	clear
	echo "User details....!"
	echo ""
	grep bin/sh /etc/passwd | awk -F: '{print $1, $3}'
	echo ""

	echo "x - Back to user management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
 	read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        user_management
                        ;;
                "h" )
                        home_page
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac
}




home_page
