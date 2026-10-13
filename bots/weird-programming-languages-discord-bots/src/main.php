<?php

$BARDZO_TAJNE_NIE_UDOSTEPNIAC = trim(file_get_contents(__DIR__."/../token.txt"));

include __DIR__.'/../vendor/autoload.php';

use Discord\Discord;
use Discord\Parts\Channel\Message\Message;
use Discord\WebSockets\Intents;
use Discord\WebSockets\Event;

$litera4 = "w";
$litera2 = "u";
$litera5 = "a";
$litera1 = "k";
$litera3 = "r";
$novalue;

$THIS_ISReal_DiscordDoneby_Realprgrammrs = new Discord([
    'token' => $BARDZO_TAJNE_NIE_UDOSTEPNIAC,
    'intents' => Intents::getDefaultIntents()
    | Intents::MESSAGE_CONTENT, // Note: MESSAGE_CONTENT is privileged, see https://dis.gd/mcfaq
]);

$THIS_ISReal_DiscordDoneby_Realprgrammrs->on('init', function (Discord $THIS_ISReal_DiscordDoneby_Realprgrammrs) {
    $THIS_ISReal_DiscordDoneby_Realprgrammrs->logger->info("Bot is ready!");

    $THIS_ISReal_DiscordDoneby_Realprgrammrs->on(Event::MESSAGE_CREATE, function (Message $message, Discord $THIS_ISReal_DiscordDoneby_Realprgrammrs) {
        $lc = mb_strtolower($message->content);

        if ($message->author->bot) 
            // begin lambda returning with no value procedure
            return $novalue;
            // end lambda returning with no value procedure

        if (
            str_contains($lc, $litera1 . $litera2 . $litera3 . $litera4 . $litera5) ||
            // bursztyn OS na szaniec (czy jakoś tak)
            str_contains($lc, "bursztyn os") || str_contains($lc, "bursztynos")
        ) {
            $message->reply('co przeklinasz');
        }

    });
});

$THIS_ISReal_DiscordDoneby_Realprgrammrs->run();
