#include <SDL3/SDL.h>
#include <SDL3_image/SDL_image.h>
#include <SDL3/SDL_surface.h>

int main(int argc, char* argv[]){
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;
    SDL_Event event;

    //Initializes video
    bool init = SDL_Init(SDL_INIT_VIDEO);

    if(!init){
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, 
                "Couldn't initialize SDL: %s", SDL_GetError());
        return 3;
    }

    bool createWindow = SDL_CreateWindowAndRenderer("Hello SDL", 
            1920, 1080, SDL_WINDOW_OPENGL, &window, &renderer); 

    if(!createWindow){
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't create window and renderer: %s", SDL_GetError());
        return 3;
    }

    texture = IMG_LoadTexture(renderer, "./assets/Dog.jpeg");
    if (!texture) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't create texture from surface: %s", SDL_GetError());
        return 3;
    }
   
    SDL_FRect rect{100, 100, 500, 500};
    SDL_FPoint pivot{0, 0};
    double angle = 12.5;
    SDL_FlipMode flip = SDL_FLIP_NONE;

    while (1) {
        SDL_PollEvent(&event);
        if (event.type == SDL_EVENT_QUIT) {
            break;
        }
        SDL_SetRenderDrawColor(renderer, 0x00, 0x00, 0x00, 0x00);
        SDL_RenderClear(renderer);
        SDL_RenderTextureRotated(renderer, texture, NULL, &rect, angle, &pivot, flip);
        SDL_RenderPresent(renderer);
    }

    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);

    SDL_Quit();

    return 0;
}
