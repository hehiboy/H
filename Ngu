import pygame
import time
import sys
import random

pygame.init()
screen = pygame.display.set_mode((0, 0), pygame.FULLSCREEN)
width, height = screen.get_size()
jump_image = pygame.image.load("horror_image.jpg")
jump_image = pygame.transform.scale(jump_image, (width, height))
jump_sound = pygame.mixer.Sound("scream.wav")

def flash_screen(duration=2, speed=0.05):
    end_time = time.time() + duration
    colors = [(255, 255, 255), (0, 0, 0)]
    while time.time() < end_time:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
        screen.fill(random.choice(colors))
        pygame.display.flip()
        time.sleep(speed)

flash_screen(duration=3, speed=0.03)
screen.blit(jump_image, (0, 0))
pygame.display.flip()
jump_sound.play()
time.sleep(4)
pygame.quit()
sys.exit()
