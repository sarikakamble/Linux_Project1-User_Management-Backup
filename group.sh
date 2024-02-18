#!/bin/bash

group_mgmt(){
        clear
	echo "Gorup Manegament...!"
        echo ""
        echo "c - Create Group...!"
        echo ""
        echo "a - Add users in group...!"
        echo ""
        echo "r - Remove users from group...!"
	echo ""
	echo "d - Delete a group...!"
	echo ""
	echo "s - Show Groups...!"
        echo ""
        echo "h - Back To Home Page "
        echo ""
	echo "e - Exit"
        read -p "What do you want to do: " choice

        case $choice in
                "c" )
                        create_group
                        ;;
                "a" )
                        user_add
                        ;;
                "r" )
                        user_remove
                        ;;
                "d" )
                        group_delete
                        ;;
		"s" )
			show_group
			;;
                "h" )
                        ./user.sh
                        ;;
		"e" )
			clear
			exit
			;;
        esac
}

create_group(){
	clear
	echo "Group Creation....!"
	echo ""

	read -p "Please enter your group name : " grp_name

	if grep -q "^$grp_name" /etc/group; then
  		echo "Group already exists....!"
		echo ""
	else
		echo ""
		sudo groupadd $grp_name
   	        echo "New group created successfully....!"
	fi

	echo "x - Back to group management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
 	read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        group_mgmt
                        ;;
                "h" )
                        ./user.sh
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac
}

user_add(){
	clear
	echo "Add users in group....!"
	echo ""
	
	read -p "Enter group name : " grp_name
	echo ""

	 if grep -q "^$grp_name" /etc/group; then
         	read -p "Enter user name : " user_name
                echo ""

		if id $user_name &>/dev/null; then
		        sudo gpasswd -a $user_name $grp_name
	       		echo ""
 		else
			echo "$user_name is not found"
			echo ""
		fi			
        else
                echo ""
                echo "$grp_name is not found"
		echo ""
        fi

	echo "x - Back to group management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
 	read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        group_mgmt
                        ;;
                "h" )
                        ./user.sh
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac

}

user_remove(){
	clear
        echo "Removing users in group....!"
        echo ""

        read -p "Enter group name : " grp_name
        echo ""

         if grep -q "^$grp_name" /etc/group; then
                read -p "Enter user name : " user_name
                echo ""

                if id $user_name &>/dev/null; then
                        sudo gpasswd -d $user_name $grp_name
                        echo ""
                else
                        echo "$user_name is not found"
                        echo ""
                fi
        else
                echo ""
                echo "$grp_name is not found"
                echo ""
        fi

	echo "x - Back to group management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
        read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        group_mgmt
                        ;;
                "h" )
                        ./user.sh
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac
}

group_delete(){
	clear
	echo "Delete the group...!"
	echo ""

	read -p "Enter group name : " grp_name
        echo ""

        if grep -q "^$grp_name" /etc/group; then
		sudo groupdel $grp_name
		echo "$grp_name is deleted successfully."
	else
		echo "$grp_name is found"
	fi

	echo "x - Back to group management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
        read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        group_mgmt
                        ;;
                "h" )
                        ./user.sh
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac
	
}


show_group(){
	clear
	echo "Groups details...!"

	sudo cat /etc/group

	echo "x - Back to group management"
        echo ""
        echo "h - Back to home"
        echo ""
        echo "e - Exit"
        echo ""
 	read -p "Please enter your choice : " choice

        case $choice in
                "x" )
                        group_mgmt
                        ;;
                "h" )
                        ./user.sh
                        ;;
                "e" )
                        clear
                        exit
                        ;;
        esac
}



group_mgmt
