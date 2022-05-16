package Weiberle.Bot;

import javax.security.auth.login.LoginException;

import Weiberle.Bot.Commands.Commands;
import net.dv8tion.jda.api.JDABuilder;
import net.dv8tion.jda.api.OnlineStatus;
import net.dv8tion.jda.api.entities.Activity;

public class MainBot {

	public static String prefix = "!";
	
	public static void main(String[] args) throws LoginException {
		 
		JDABuilder jda = JDABuilder.createDefault("OTA3MjQwMzcxMzM0MDQxNjAw.YYkTcA.a-r444Inkxe8ToCcK3txLWUAkMI");
		jda.setStatus(OnlineStatus.ONLINE);
		jda.setActivity(Activity.watching("YouTube"));
		jda.addEventListeners(new Commands());
		jda.build();
		
	}
}