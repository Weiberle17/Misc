package Weiberle.Bot.Commands;

import java.util.List;

import Weiberle.Bot.MainBot;
import net.dv8tion.jda.api.EmbedBuilder;
import net.dv8tion.jda.api.entities.Message;
import net.dv8tion.jda.api.events.message.guild.GuildMessageReceivedEvent;
import net.dv8tion.jda.api.hooks.ListenerAdapter;

public class Commands extends ListenerAdapter {

	public static String[] msg;

	@SuppressWarnings("deprecation")
	public void onGuildMessageReceived(GuildMessageReceivedEvent event) {

		eingabe(event);
		help(event);
		test(event);
		clear(event);

	}

	public void eingabe(GuildMessageReceivedEvent event) {

		msg = event.getMessage().getContentRaw().split(" ");

	}

	public void help(GuildMessageReceivedEvent event) {

		if (msg[0].equalsIgnoreCase(MainBot.prefix + "help")) {

			//Help function
			EmbedBuilder help = new EmbedBuilder();
			help.setTitle("Commands: ");
			help.addField(MainBot.prefix + "help", "List all commands.", false);
			help.addField(MainBot.prefix + "test", "Test response.", false);
			help.addField(MainBot.prefix + "clear", "Delete messages", true);
			event.getChannel().sendMessage(help.build()).queue();
			
		}
	}

	public void test(GuildMessageReceivedEvent event) {

		if (msg[0].equalsIgnoreCase(MainBot.prefix + "test")) {

			event.getMessage().reply("This Bot works!").queue();

		}
	}

	public void clear(GuildMessageReceivedEvent event) {

		if (msg[0].equalsIgnoreCase(MainBot.prefix + "clear")) {

			if (msg.length < 2) {

				//Number of messages not specified
				EmbedBuilder usage = new EmbedBuilder();
				usage.setColor(0xff3923);
				usage.setTitle("Specify the amount of messages you want to delete");
				usage.setDescription("Usage: " + MainBot.prefix + "clear [#number of messages you want to delete]");
				event.getChannel().sendMessage(usage.build()).queue();

			} else {

				try {

					List<Message> message = event.getChannel().getHistory().retrievePast(Integer.parseInt(Commands.msg[1])).complete();
					event.getChannel().deleteMessages(message).queue();

				}
				catch (IllegalArgumentException e) {

					if (e.toString().startsWith("java.lang.IllegalArgumentException: Message retrieval")) {

						//Too many messages
						EmbedBuilder error = new EmbedBuilder();
						error.setColor(0xff3923);
						error.setTitle("Too many messages selected!");
						error.setDescription("Between 1-100 messages can be deleted at once");
						event.getChannel().sendMessage(error.build()).queue();

					} else {

						//Messages too old
						EmbedBuilder error = new EmbedBuilder();
						error.setColor(0xff3923);
						error.setTitle("Selected messages are older than 2 weeks!");
						error.setDescription("Messages older than 2 weeks can not be deleted");
						event.getChannel().sendMessage(error.build()).queue();

					}
				}
			}	
		}
	}
}